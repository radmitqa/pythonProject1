*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${Base_URL}  http://thetestingworldapi.com
${Student_ID}  1

*** Test Cases ***
TC_002_Get_Request_Specific_Student
    [Tags]  Smoke
    create session  FetchData  ${Base_URL}
    ${Response}=  GET On Session  FetchData  api/StudentsDetails/${Student_ID}
    ${ActualCode}=  convert to string  ${Response.status_code}
    BuiltIn.Should Be Equal  ${ActualCode}  200
    log to console  ${Response.status_code}
    log to console  ${Response.content}
    log  ${Response.status_code}
    log  ${Response.content}
