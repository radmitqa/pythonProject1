*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${base_URL}  https://thetestingworldapi.com/

*** Test Cases ***
TC_006_Post_Request
    [Tags]  Smoke
    create session  Add_New_Student  ${base_URL}
    &{body}=  create dictionary  first_name=Name3  middle_name=B  last_name=LName3  date_of_birth=11/12/1900
    &{header}=  create dictionary  Content-Type=application/json
    ${response}=  POST REQUEST  Add_New_Student  /api/studentsDetails  data=&{body}  headers=&{header}
    Log to console  ${response.status_code}
    ${response_code}=  convert to string  ${response.status_code}
    BuiltIn.Should Be Equal  ${response_code}  201
    #  Log to console  ${response.content}
    Log to console  ${response.json()}

    ${json_response}=  to json  ${response.content}

    @{first_name_list}=  get value from json  ${json_response}  first_name
    ${first_name}=  get from list  ${first_name_list}  0
    Log to console  ${first_name}
    BuiltIn.Should Be Equal  ${first_name}  Name3

    @{middle_name_list}=  get value from json  ${json_response}  middle_name
    ${middle_name}=  get from list  ${middle_name_list}  0
    log to console  ${middle_name}
    BuiltIn.Should Be Equal  ${middle_name}  B

    @{last_name_list}=  get value from json  ${json_response}  last_name
    ${last_name}=  get from list  ${last_name_list}  0
    log to console  ${last_name}
    BuiltIn.Should Be Equal  ${last_name}  LName3

    @{dob_list}=  get value from json  ${json_response}  date_of_birth
    ${date_of_birth}=  get from list  ${dob_list}  0
    log to console  ${date_of_birth}
    BuiltIn.Should Be Equal  ${date_of_birth}  11/12/1900




