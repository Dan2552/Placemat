import Quick
import Nimble
import Placemat

class StringConvertersSpec: QuickSpec {
    override func spec() {
        describe("nameFor(object:)") {
            it("returns the name of the class for a given instance or class") {
                expect(String.nameFor(object: ThisIsATest())).to(equal("ThisIsATest"))
                expect(String.nameFor(object: AnotherTest())).to(equal("AnotherTest"))
                expect(String.nameFor(object: ThisIsATest.self)).to(equal("ThisIsATest"))
                expect(String.nameFor(object: AnotherTest.self)).to(equal("AnotherTest"))
            }
        }
        
        describe("-firstCharacterUpperCase") {

            it("makes the first character uppercase") {
                let values = [
                    "banana",
                    "a",
                    "hello world",
                    "hello_world",
                    "helloWorld",
                    "HelloWorld"
                ]
                
                let expected_results = [
                    "Banana",
                    "A",
                    "Hello world",
                    "Hello_world",
                    "HelloWorld",
                    "HelloWorld"
                ]
                
                let results = values.map { s in return s.changingCaseOf(firstCharacter: .upper) }

                expect(expected_results) == results
            }
        }
        
        describe("-firstCharacterLowerCase") {
            
            it("makes the first character uppercase") {
                let values = [
                    "Banana",
                    "A",
                    "Hello world",
                    "Hello_world",
                    "HelloWorld"
                ]
                
                let expected_results = [
                    "banana",
                    "a",
                    "hello world",
                    "hello_world",
                    "helloWorld"
                ]
                
                let results = values.map { s in return s.changingCaseOf(firstCharacter: .lower) }
                
                expect(expected_results) == results
            }
        }
        
        describe("-camelCase") {
            
            it("returns the string in CamelCase form") {
                let values = [
                    "time_entry",
                    "post",
                    "AlreadyCamelCase"
                ]
                
                let expected_results = [
                    "TimeEntry",
                    "Post",
                    "AlreadyCamelCase"
                ]
                
                let results = values.map { s in return s.camelCased() }
                
                expect(expected_results) == results
            }
        }
        
        describe("-camelCaseLower") {
            
            it("returns the string in camelCase form") {
                let values = [
                    "time_entry",
                    "post",
                    "alreadyCamelCase"
                ]
                
                let expected_results = [
                    "timeEntry",
                    "post",
                    "alreadyCamelCase"
                ]
                
                let results = values.map { s in return s.camelCased(firstCharacterCase: .lower) }
                
                expect(expected_results) == results
            }
        }
        
        describe("-pluralize") {
            
            it("returns the string as a plural form") {
                let values = [
                    "time_entry",
                    "post",
                    "address",
                    "category",
                    "money"
                ]
                
                let expected_results = [
                    "time_entries",
                    "posts",
                    "addresses",
                    "categories",
                    "monies"
                ]
                
                let results = values.map { s in return s.pluralize() }
                
                expect(expected_results) == results
            }
        }
        
        describe("-underscoreCase") {
            
            it("returns the string in lowercase form") {
                let values = [
                    "banana",
                    "a",
                    "hello_world",
                    "helloWorld",
                    "HelloWorld"
                ]
                
                let expected_results = [
                    "banana",
                    "a",
                    "hello_world",
                    "hello_world",
                    "hello_world"
                ]
                
                let results = values.map { s in return s.underscoreCased() }
                
                expect(expected_results) == results
            }
        }
        
    }
}
