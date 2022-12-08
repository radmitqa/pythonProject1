*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${base_url}  https://dev-n69d386hw4b698w.api.raw-labs.com/2
${base_url_1}  https://dev-n69d386hw4b698w.api.raw-labs.com/3?country=Belgium&minYear=1977&maxYear=1978&code=L53.8

*** Test Cases ***
TC_101_Get_Request_All_Countries
    [Tags]  Regression
    create session  Get All Data  ${base_url_1}
    ${response}=  GET on Session  Get All Data  ${base_url_1}
    Log to console  ${response.status_code}
    Log to console  ${response.json()}