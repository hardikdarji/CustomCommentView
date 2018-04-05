//
//  Model.swift
//  customComment
//
//  Created by hardik.darji on 3/28/18.
//  Copyright © 2018 gatewaytechnolabs. All rights reserved.
//

import Foundation
class Model: NSObject
{
    var commentCount: Int = 0
    var commentText: String = ""
    
    required init?(count: Int = 0, text: String = "") {
        self.commentText = text
        self.commentCount = count
    }

    class func getInitData() -> [Model]
    {
        var models:[Model] = []
           models.append(Model(count: 0, text: "SSC exam fraud: Delhi Police, UP STF bust racket that used screen sharing software to cheat")!)
        models.append(Model(count: 0, text: "The accused persons would gain access to the computer systems of the candidates who paid the money. The solver would then answer all the questions using the software. When the Team Viewer software could not be used, they would take control of the computer by fixing the LAN connections with that of another computer in the exam centre and answer all the questions,” DSP (UP STF) Brijesh Singh said")!)
        models.append(Model(count: 0, text: "According to sources in the UP STF, Harpal and Sonu were the main gang leaders. The two accused were in a partnership as Harpal would provide the necessary infrastructure while Sonu would help in getting candidates.")!)
        models.append(Model(count: 0, text: "According to the police, the gang started operating in 2011. The members had made their initial forays into the cheating gang by setting up dummy candidates in written exams. Later, when the online exam format had begun, the gang members thought of using team viewer software and also procured examination centres to facilitate cheating, police said.\nThe UP STF had got inputs about Sonu’s involvement in the gang and mounted surveillance for 15 days. “We wanted evidence against Sonu before the raid. So we waited for him to make his move. Our officers caught him in a team viewer session around 10:30 am helping a candidate solve his paper. The Delhi Police was then informed about the raid,” Singh said.")!)
        models.append(Model(count: 0, text: "any more with this text ....According to the police, the gang started operating in 2011. The members had made their initial forays into the cheating gang by setting up dummy candidates in written exams. Later, when the online exam format had begun, the gang members thought of using team viewer software and also procured examination centres to facilitate cheating, police said.\nThe UP STF had got inputs about Sonu’s involvement in the gang and mounted surveillance for 15 days. “We wanted evidence against Sonu before the raid. So we waited for him to make his move. Our officers caught him in a team viewer session around 10:30 am helping a candidate solve his paper. The Delhi Police was then informed about the raid,” Singh said.")!)
        return models
    }
}
