//
//  DescriptionViewController.swift
//  ARExample
//
//  Created by Fabian Ettinger on 23.05.22.
//

import UIKit
import AVFoundation

class DescriptionViewController: UIViewController {
    
    var model: Model? = nil
    var player: AVAudioPlayer?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coordsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var audioButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let current = model?.getCurrent(), let d = model?.descriptions {
            titleLabel.text = current.anchor;
            coordsLabel.text = "lat: \(current.lat), long: \(current.long)"
            for descr in d {
                if descr.forAnchor == current.anchor {
                    descriptionLabel.text = descr.text
                }
            }
            
        }
    }
    
    @IBAction func onTouchUpInside(_ sender: Any) {
        if let player = player, player.isPlaying {
            audioButton.setTitle("Play Audio", for: .normal)
            player.stop()
        } else {
            audioButton.setTitle("Stop Audio", for: .normal)
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true)
                
                let url = Bundle.main.path(forResource: "welcome", ofType: "wav")
                guard let url = url else {
                    print("no audio")
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))
                guard let player = player else {
                    print("no player")
                    return
                }

                player.play()
            } catch {
                print("audio player error")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
