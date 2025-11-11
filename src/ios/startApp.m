#import "startApp.h"
#import <Cordova/CDV.h>

@implementation startApp

- (void)check:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;

    NSString* scheme = [command.arguments objectAtIndex:0];

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:scheme]]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    }
    else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsBool:NO];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)start:(CDVInvokedUrlCommand*)command {
    NSString* scheme = [command.arguments objectAtIndex:0];
    NSURL *url = [NSURL URLWithString:scheme];

    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            CDVPluginResult *result = success ?
                [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES] :
                [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsBool:NO];

            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }];
    }
    else {
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsBool:NO];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }
}

- (void)go:(CDVInvokedUrlCommand*)command {
    NSString* scheme = [command.arguments objectAtIndex:0];
    NSURL *url = [NSURL URLWithString:scheme];

    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
        CDVPluginResult *result = success ?
            [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES] :
            [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsBool:NO];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

@end
