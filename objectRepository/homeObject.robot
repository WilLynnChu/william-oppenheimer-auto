*** Settings ***
Documentation       Object repository for home page
Library             SeleniumLibrary

*** Variables ***
#Buttons
${btn_refresh_table_home}               //button[normalize-space()='Refresh Tax Relief Table']
${btn_visit_swagger_home}               //a[text()='Visit Swagger']
${btn_dispense_now_home}                //a[@class='btn btn-danger btn-block' and text() = 'Dispense Now']

#Datas
${data_working_class_hero_10}           /Users/willynn/PycharmProjects/oppenheimer-auto/dataFiles/workingClassHero10.csv
${data_working_class_hero_100}          /Users/willynn/PycharmProjects/oppenheimer-auto/dataFiles/workingClassHero100.csv

#Inputs
${input_upload_file_home}               //input[@type='file']

#Labels
${label_empty_record_message_home}      //div[@id='contents']/h1[contains(text(),'No records at the moment')]
${label_total_relief_message_home}      //h1[text()='Total Tax Relieves']
${label_relief_summary_home}            ${label_total_relief_message_home}/following-sibling::p[contains(@class,'lead')]
${label_cash_dispensed_dispensed_page}  //div[text()='Cash dispensed']

#Tables
${table_header_natid_home}              //table[@class='table table-hover table-dark']/descendant::th[text()='NatId']
${table_header_relief_home}             //table[@class='table table-hover table-dark']/descendant::th[text()='Relief']
${table_body_home}                      //table[@class='table table-hover table-dark']/tbody
