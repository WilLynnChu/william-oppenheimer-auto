*** Settings ***
Documentation    Object repository for API requests

*** Variables ***
${BASE_URL}     http://localhost:8080
${api_post_insert_single_hero_record}   ${BASE_URL}/calculator/insert
${api_post_insert_mult_hero_record}     ${BASE_URL}/calculator/insertMultiple
${api_get_tax_relief_details}           ${BASE_URL}/calculator/taxRelief
${api_get_tax_relief_summary}           ${BASE_URL}/calculator/taxReliefSummary
${api_post_rake_database}               ${BASE_URL}/calculator/rakeDatabase