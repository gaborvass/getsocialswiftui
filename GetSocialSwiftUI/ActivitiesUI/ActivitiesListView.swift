//
//  ActivitiesListView.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 20/12/2019.
//  Copyright © 2019 Keywords Studios. All rights reserved.
//

import SwiftUI
import GetSocial

enum Sheets {
    case None
    case ShowPostActivity
    case ShowImage
    case ShowVideo
    case ShowDetail
}

struct ActivitiesListView: View {

    @ObservedObject
    var activitiesViewModel: ActivitiesViewModel = ActivitiesViewModel()

    @State
    var showReportActivityView = false

    @State
    var showSheet: Bool = false

    @State
    var activeSheet: Sheets = .None {
        didSet {
            showSheet = self.activeSheet != .None
        }
    }

    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }

    @State
    var selectedActivity: GetSocialActivityPost?

    var body: some View {
        ZStack {
            List {
                ForEach(self.activitiesViewModel.activities, id: \.activityId) { activity in
                    ActivitiesListItemView(activity: activity, onMoreButtonTap: {
                        self.selectedActivity = activity
                        self.showReportActivityView = true
                    }, onVideoTap: {
                        self.selectedActivity = activity
                        self.activeSheet = .ShowVideo
                    }, onImageTap: {
                        self.selectedActivity = activity
                        self.activeSheet = .ShowImage
                    }, onLikeTap: {
                        self.selectedActivity = activity
                        self.activitiesViewModel.likeActivity(activity)
                    }).listRowInsets(EdgeInsets())
                }
            }
            if self.activitiesViewModel.showActivityIndicator {
                ActivityIndicatorView()
            }
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Button(action: {
                        self.activeSheet = .ShowPostActivity
                    }) {
                        Image(systemName: "paperplane")
                            .resizable()
                            .frame(width: 32, height: 32, alignment: .center)
                    }
                }.padding(.bottom, 16)
            }.padding(.trailing, 16)
        }.sheet(isPresented: self.$showSheet) {
            if self.activeSheet == .ShowVideo {
                ActivityVideoView(videoURL: self.selectedActivity!.videoUrl!, imageURL: self.selectedActivity!.imageUrl!)
            }
            if self.activeSheet == .ShowImage {
                ActivityImageView(imageURL: self.selectedActivity!.imageUrl!)
            }
            if self.activeSheet == .ShowPostActivity {
                PostActivityView(viewModel: self.activitiesViewModel).padding(16).frame(maxHeight: 200)
            }
        }.actionSheet(isPresented: self.$showReportActivityView) {
            ActionSheet(title: Text("Report"), buttons: [.destructive(Text("Spam")){
                self.activitiesViewModel.reportActivity(self.selectedActivity!.activityId, reason: 0)
                }, .destructive(Text("Other")){
                    self.activitiesViewModel.reportActivity(self.selectedActivity!.activityId, reason: 1)
                }, .cancel(Text("Cancel"))])
        }.onAppear {
            self.activitiesViewModel.loadInitialData()
        }
    }
}
//
//struct ActivitiesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivitiesListView()
//    }
//}
