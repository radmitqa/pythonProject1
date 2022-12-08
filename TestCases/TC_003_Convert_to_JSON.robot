*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${Base_URL}  https://thetestingworldapi.com
${Student_ID}  0

*** Test Cases ***
TC_003_Convert_To_JSON
    [Tags]  Regression
    create session  FetchData  ${Base_URL}
    ${response}=  GET On Session  FetchData  api/studentsDetails/${Student_ID}
    ${actual_code}=  convert to string  ${Response.status_code}
    BuiltIn.Should Be Equal  ${actual_code}  200
    log to console  ${Response.status_code}

    ${json_response}=  to json  ${response.content}
    log to console  ${response.content}

    @{first_name_list}=  get value from json  ${json_response}  first_name
    ${first_name}=  get from list  ${first_name_list}  0
    log to console  ${first_name}
    BuiltIn.Should Be Equal  ${first_name}  Test Student

    @{last_name_from_list}=  get value from json  ${json_response}  last_name
    ${last_name}=  get from list  ${last_name_list}  0
    log to console  ${last_name}
    BuiltIn.Should Be Equal  ${last_name}  Automation
