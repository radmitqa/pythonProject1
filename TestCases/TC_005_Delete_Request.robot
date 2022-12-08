*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${base_URL}  https://thetestingworldapi.com

*** Test Cases ***
TC_005_Delete_Request
    [Tags]  Smoke
    create session  Delete_Specific_Student  ${base_URL}
    ${response}=  DELETE On Session  Delete_Specific_Student  /api/studentsDetails/28
    ${actual_status_code}=  convert to string  ${response.status_code}
    log to console  ${actual_status_code}
    BuiltIn.Should Be Equal  ${actual_status_code}  200

    ${json_response}=  to json  ${response.content}
    @{status_list}=  get value from json  ${json_response}  status
    log to console  @{status_list}
# !!!---Setting to false bcs DB changed---
#    ${status}=  get from list  @{status_list}  0
#    ${actual_status}=  convert to string  ${status}
    BuiltIn.Should Be Equal  ${status_list[0]}  false
