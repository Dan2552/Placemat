

import Quick
import Nimble
import Placemat

class DictionarySupportSpec: QuickSpec {
    override func spec() {
        
        let dictionary = [
            "testingOne": "blahBlah",
            "testingTwo": "blah",
            "testing_three": "blah"
        ] as NSDictionary
        
        describe("-only") {
            let onlyDictionary = dictionary.only(["testingTwo", "testing_three"])
            
            it("filters to only include the keys provided"){
                expect(onlyDictionary.count).to(equal(2))
                expect(onlyDictionary["testingTwo"]).toNot(beNil())
                expect(onlyDictionary["testing_three"]).toNot(beNil())
            }
        }
        
        describe("-underscoreKeys") {
            
            let newDictionary = dictionary.underscoreKeys()
            
            it("returns the same dictionary but with the keys changed to underscore_formatting") {
                expect(newDictionary.keys).to(contain("testing_one"))
                expect(newDictionary.keys).to(contain("testing_two"))
                expect(newDictionary.keys).to(contain("testing_three"))
            }

            it("does nothing to the values") {
                let values = [
                    newDictionary["testing_one"]! as! String,
                    newDictionary["testing_two"]! as! String,
                    newDictionary["testing_three"]! as! String
                ]
                
                let expectations = [
                    "blahBlah",
                    "blah",
                    "blah"
                ]
                
                expect(values).to(equal(expectations))
            }
        }
    }
}
