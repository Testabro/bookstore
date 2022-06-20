package business.customer;

import java.util.Calendar;
import java.util.Date;


public class CustomerForm {

    private String name;
    private String address;
    private String phone;
    private String email;
    private String ccNumber;
    private String ccMonth;
    private String ccYear;
    private Date ccExpDate;

    private boolean hasNameError;
    private boolean hasAddressError;
    private boolean hasPhoneError;
    private boolean hasEmailError;
    private boolean hasCcNumberError;
    private boolean hasCcExpDateError;

    public CustomerForm() {
        this.name = "";
        this.address = "";
        this.phone = "";
        this.email = "";
        this.ccNumber = "";
        this.ccMonth = "";
        this.ccYear = "";
        this.ccExpDate = getCcExpDate("1", "2024");
        validate();
     }

    public CustomerForm(String name, String address, String phone, String email, String ccNumber, String ccMonth, String ccYear) {
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.ccNumber = ccNumber;
        this.ccMonth = ccMonth;
        this.ccYear = ccYear;
        this.ccExpDate = getCcExpDate(ccMonth, ccYear);
        validate();
    }

    // Get methods for fields

    public String getName() {
        return name;
    }
    public String getAddress() { return address; }
    public String getPhone() { return phone; }
    public String getEmail() { return email; }
    public String getCcNumber() { return ccNumber; }
    public String getCcMonth() { return ccMonth; }
    public String getCcYear() { return ccYear; }
    public Date getCcExpDate() { return ccExpDate; }

    // hasError methods for fields

    public boolean getHasNameError() {
        return hasNameError;
    }
    public boolean getHasAddressError() { return hasAddressError; }
    public boolean getHasPhoneError() { return hasPhoneError; }
    public boolean getHasEmailError() { return hasEmailError; }
    public boolean getHasCcNumberError() { return hasCcNumberError; }
    public boolean getHasCcExpDateError() { return hasCcExpDateError; }
    public boolean getHasFieldError() {
        return hasNameError | hasAddressError | hasPhoneError | hasEmailError | hasCcNumberError | hasCcExpDateError;
    }

    // error messages for fields

    public String getNameErrorMessage() {
        return "Valid name required (ex: Bilbo Baggins)";
    }
    public String getAddressErrorMessage() { return "Valid address required (ex: 880 Harrision St. SE)";}
    public String getPhoneErrorMessage() {return "Valid US phone number required (ex: 703-555-3245)"; }
    public String getEmailErrorMessage() {return "Valid email required (ex: gizmoto@spaceship.org)"; }
    public String getCcNumberErrorMessage() { return "Valid credit card number required (between 14-16 numbers only)"; }
    public String getCcExpDateErrorMessage() { return "CC expiration date must be later then today"; }

    private void validate() {
        //Name will be valid if it is not null, not empty, and greater then 45 character
        if (name == null | name.isEmpty() | name.length() > 45) {
            hasNameError = true;
        }

        //Address will be valid if not null, not empty, and greater then 125 character
        if (address == null | address.isEmpty() | address.length() > 125) {
            hasAddressError = true;
        }

        //Phone number valid if after removing all spaces, dashes, and parens from the string it should have exactly 10 digits
        boolean phoneIsInvalid = false;
        //Remove all spaces, parenth, and dashes from phone number
        String phoneDigits = phone;
        phoneDigits = phoneDigits.replaceAll(" ", "");
        phoneDigits = phoneDigits.replaceAll("[()]", "");
        phoneDigits = phoneDigits.replaceAll("-", "");
        phoneDigits = phoneDigits.replaceAll("-", "");


        if(!phoneDigits.matches("\\d+")){
            phoneIsInvalid = true;
        }

        if(phoneDigits.length() != 10){
            phoneIsInvalid = true;
        }

        if(phoneIsInvalid){
            hasPhoneError = true;
        }

        //A valid email should not contain spaces; should contain a "@"; and the last character should not be "."

        boolean emailIsInvalid = false;
        int last_in = 0;
        int lastIndexOfEmail = 0;

        if(email.length() > 1){
            lastIndexOfEmail = email.length() - 1;
        }
        //Check for . at end of email
        if(email.contains(".")){
            last_in = email.lastIndexOf(".");
        }

        if(email.contains(" ") || last_in == lastIndexOfEmail) {
            emailIsInvalid = true;
        }else if(email.contains("@")){
            emailIsInvalid = false;
        }else{
            emailIsInvalid = true;
        }
        //Final check if email is valid makes it accessible outside of this class
        if (email == null | email.isEmpty()) {
            hasEmailError = true;
        }
        if(emailIsInvalid){
            hasEmailError = true;
        }

        //A valid credit card number is, after removing spaces and dashes, a collection of number characters between 14 and 16.
        boolean ccNumIsInvalid = false;
        //Remove all spaces and dashes from ccNumber
        String ccNumDigits = ccNumber.replaceAll(" ", "");
        ccNumDigits = ccNumDigits.replaceAll("-", "");

        if(ccNumDigits.matches("\\d+") & ccNumDigits.length() >= 14 & ccNumDigits.length() <= 16){
            ccNumIsInvalid = false;
        }else {
            ccNumIsInvalid = true;
        }
        //Final check for invalid ccNumber
        if(ccNumIsInvalid){
            hasCcNumberError = true;
        }
        //A valid expiration date is should be today(month and year) or later
        Calendar calendar = Calendar.getInstance();
        Date timeToCompare = calendar.getTime();

        if (timeToCompare.after(ccExpDate)) {
            hasCcExpDateError = true;
        }
    }

    // Returns a Java date object with the specified month and year
    private Date getCcExpDate(String monthString, String yearString) {

        int monthInt = Integer.parseInt(monthString);
        //adjust real month date to java month (i.e 0-Jan) by subtracting 1
        monthInt = monthInt - 1;
        int yearInt = Integer.parseInt(yearString);

        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.MONTH, monthInt);
        calendar.set(Calendar.YEAR, yearInt);
        Date ccExpDate =  calendar.getTime();

        return ccExpDate;
    }
}
