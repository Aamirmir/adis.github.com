/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.

#import <UIKit/UIKit.h>

%hook ClassName

// Hooking a class method
+ (id)sharedInstance {
	return %orig;
}

// Hooking an instance method with an argument.
- (void)messageName:(int)argument {
	%log; // Write a message about this call, including its class, name and arguments, to the system log.

	%orig; // Call through to the original function with its original arguments.
	%orig(nil); // Call through to the original function with a custom argument.

	// If you use %orig(), you MUST supply all arguments (except for self and _cmd, the automatically generated ones.)
}

// Hooking an instance method with no arguments.
- (id)noArguments {
	%log;
	id awesome = %orig;
	[awesome doSomethingElse];

	return awesome;
}

// Always make sure you clean up after yourself; Not doing so could have grave consequences!
%end
*/

%hook ViewController

- (void)viewDidLoad
{
	%orig
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hello"
                                                                   message:@"You've been jailbreak broken."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Okey dokey"
                                                 style:UIAlertActionStyleDefault
                                               handler:nil];

    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

%end

// Class used to check for jailbreaks
%hook JBChecker

// Redefine the behavior of the function that checks
// for jailbreaks
+ (BOOL)isJailbroken
{
	%log;
	NSLog(@"Using the hooked JB method");
	return NO;
}

%end