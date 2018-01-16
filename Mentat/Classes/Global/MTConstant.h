//
//  MTConstant.h
//  Mentat
//
//  Created by Fabio Alexandre on 26/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#ifndef Mentat_MTConstant_h
#define Mentat_MTConstant_h

#define INTERFACE_IS_PAD     ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define INTERFACE_IS_PHONE   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

#define KMentatServerURL                    @"http://prod-mentat.herokuapp.com/api/"

// Define Color
#define KColorMenuBackground                @"#233645"
#define KColorChildMenuBackground           @"#293846"
#define KColorChildMenuText                 @"#a7b1c2"
#define KColorSelectedMenu                  @"#52617b"
#define KColorDefaultBackground             @"#f3f3f3"
#define KColorMainBlue                      @"#1ab394"
#define KColorUnActive                      @"#d1dade"

//Message content
#define KMessageServerError                 @"Your device can't access on server, try again."
#define KMessageLoginFail                   @"Login Fail"
#define KMessageLoadingFail                 @"Failed to load data."

#endif
