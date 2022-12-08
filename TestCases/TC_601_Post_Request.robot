*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${base_url}  https://reqres.in
${original_email}  1@1.net
${update_email}  2@1.net

*** Test Cases ***
TC_601_Post_Request
    [Tags]  Smoke
    create session  E2E  ${base_URL}
    &{body}=  create dictionary  email=${original_email}  password=Pass123
    &{header}=  create dictionary  Content-Type=application/json
    ${post_resp}=  POST REQUEST  E2E  /api/register  data=&{body}  headers=&{header}
    Log to console  ${post_resp.status_code}

    ${response_code}=  convert to string  ${post_resp.status_code}
    BuiltIn.Should Be Equal  ${response_code}  201
    Log to console  ${post_resp.content}
    Log to console  ${post_resp.json()}


