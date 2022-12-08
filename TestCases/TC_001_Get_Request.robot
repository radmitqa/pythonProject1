*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${base_url}  http://thetestingworldapi.com
${base_url_1}  https://api.github.com

*** Test Cases ***
TC_001_Get_Request_All_Students
    [Tags]  Smoke
    create session  Get_Student_Details  ${base_url}
    ${response}=  GET On Session  Get_Student_Details  api/studentsDetails
    Log to console  ${response.status_code}
    Log to console  ${response.content}
    Log to console  ${response.json()}

TC_011_Sample
    create session  Session1  ${base_url1}
    ${response}=  GET on Session  Session1  ${base_url1}
    Log to console  ${response.status_code}
    Log to console  ${response.json()}

