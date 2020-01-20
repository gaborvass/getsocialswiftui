//
//  GetSocial
//
//  Copyright © 2019 GetSocial BV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/*!
 * @abstract Class to update user properties.
 */
@interface GetSocialUserUpdate : NSObject

NS_ASSUME_NONNULL_BEGIN

/**
 *  Display name
 */
@property(nonatomic, copy, nullable) NSString *displayName;

/**
 *  Avatar url. You can not use it with avatar.
 */
@property(nonatomic, copy, nullable) NSString *avatarUrl;

/**
 *  Avatar image. You can not use it with avatar URL.
 */
@property(nonatomic, copy, nullable) UIImage *avatar;

#pragma mark - Public Properties

/**
 *  Adds value for the specified key to public properties
 *  If property exists with the same key, it will be replaced
 *  @param  propertyValue   Value of the property
 *  @param  propertyKey     Key of the property
 */
-(void)setPublicPropertyValue:(NSString *)propertyValue forKey:(NSString *)propertyKey;

/**
 *  Removes the specified public property
 *  @param  propertyKey Key of the property
 */
-(void)removePublicPropertyForKey:(NSString *)propertyKey;

#pragma mark - Private Properties

/**
 *  Adds value for the specified key to private properties
 *  If property exists with the same key, it will be replaced
 *  @param  propertyValue   Value of the property
 *  @param  propertyKey     Key of the property
 */
-(void)setPrivatePropertyValue:(NSString *)propertyValue forKey:(NSString *)propertyKey;

/**
 *  Removes the specified private property
 *  @param  propertyKey Key of the property
 */
-(void)removePrivatePropertyForKey:(NSString *)propertyKey;

NS_ASSUME_NONNULL_END

@end
