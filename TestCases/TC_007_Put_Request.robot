*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${base_URL}  https://thetestingworldapi.com/

*** Test Cases ***
TC_007_Put_Request
    [Tags]  Smoke
    create session  Put_Data_on_New_Student  ${base_URL}
    &{body}=  create dictionary  id=3945149  first_name=Fname1  middle_name=A  last_name=LName  date_of_birth=12/12/1900
    &{header}=  create dictionary  Content-Type=application/json
    ${response}=  PUT ON SESSION  Put_Data_on_New_Student  /api/studentsDetails/3945149  data=&{body}  headers=&{header}

    # Validate Status Code
    Log to console  ${response.status_code}
    ${response_code}=  convert to string  ${response.status_code}
    BuiltIn.Should Be Equal  ${response_code}  200

    # Validate Updated content
    Log to console  ${response.json()}
    ${response_1}=  GET ON SESSION  Put_Data_on_New_Student  /api/studentsDetails/3945149
    Log to console  ${response_1.content}

    @{first_name_list}=  get value from json  ${json_response}  first_name
    ${first_name}=  get from list  ${first_name_list}  0
    Log to console  ${first_name}
    BuiltIn.Should Be Equal  ${first_name}  Fname1

    @{middle_name_list}=  get value from json  ${json_response}  middle_name
    ${middle_name}=  get from list  ${middle_name_list}  0
    log to console  ${middle_name}
    BuiltIn.Should Be Equal  ${middle_name}  A

    @{last_name_list}=  get value from json  ${json_response}  last_name
    ${last_name}=  get from list  ${last_name_list}  0
    log to console  ${last_name}
    BuiltIn.Should Be Equal  ${last_name}  Lname

    @{dob_list}=  get value from json  ${json_response}  date_of_birth
    ${date_of_birth}=  get from list  ${dob_list}  0
    log to console  ${date_of_birth}
    BuiltIn.Should Be Equal  ${date_of_birth}  12/12/1900