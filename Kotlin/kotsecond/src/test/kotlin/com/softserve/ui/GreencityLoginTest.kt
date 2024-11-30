package com.softserve.ui

import io.github.bonigarcia.wdm.WebDriverManager
import org.junit.jupiter.api.*
import org.openqa.selenium.By
import org.openqa.selenium.WebDriver
import org.openqa.selenium.chrome.ChromeDriver
import org.openqa.selenium.support.ui.WebDriverWait
import java.time.Duration

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class LoginValidationTests {
    private val BASE_URL = "https://www.greencity.cx.ua/#/ubs"
    private val IMPLICITLY_WAIT_SECONDS = 10L
    private var driver: WebDriver? = null

    @BeforeAll
    fun setup() {
        WebDriverManager.chromedriver().setup()
        driver = ChromeDriver()
        driver!!.manage().timeouts().implicitlyWait(Duration.ofSeconds(IMPLICITLY_WAIT_SECONDS))
    }

    @AfterAll
    fun tearDown() {
        driver?.quit()
    }

    @BeforeEach
    fun setupTest() {
        driver!!.get(BASE_URL)
        Thread.sleep(1000)
        driver!!.findElement(By.cssSelector("app-ubs .ubs-header-sing-in-img.ng-star-inserted")).click()
        Thread.sleep(500)
    }

    // Email Validation Tests
    @Test
    fun testEmptyEmailAfterBlur() {
        val emailField = driver!!.findElement(By.id("email"))
        val passwordField = driver!!.findElement(By.id("password"))

        // First verify no error is shown initially
        val initialErrors = driver!!.findElements(By.cssSelector("div.validation-email-error"))
        Assertions.assertTrue(initialErrors.isEmpty() || !initialErrors[0].isDisplayed,
            "Error should not be shown before interaction")

        // Click into email field
        emailField.click()
        // Click out without entering anything
        passwordField.click()
        Thread.sleep(500)

        val error = driver!!.findElement(By.cssSelector("div.validation-email-error"))
        Assertions.assertEquals("Email is required.", error.text,
            "Empty email error should appear after field is blurred")
    }

    @Test
    fun testEmailFormatValidation() {
        val emailField = driver!!.findElement(By.id("email"))
        val passwordField = driver!!.findElement(By.id("password"))

        val invalidEmails = mapOf(
            "plaintext" to "Missing @ and domain",
            "user@" to "Missing domain",
            "@domain.com" to "Missing username",
            "user@domain" to "Missing .com",
            "user.domain.com" to "Missing @"
        )

        for ((email, description) in invalidEmails) {
            // Click into field and enter invalid email
            emailField.click()
            emailField.clear()
            emailField.sendKeys(email)
            // Click out to trigger validation
            passwordField.click()
            Thread.sleep(500)

            val error = driver!!.findElement(By.cssSelector("div.validation-email-error"))
            Assertions.assertEquals(
                "Please check if the email is written correctly",
                error.text,
                "Failed for case: $description"
            )
        }
    }

    @Test
    fun testValidEmailFormats() {
        val emailField = driver!!.findElement(By.id("email"))
        val passwordField = driver!!.findElement(By.id("password"))

        val validEmails = listOf(
            "user@domain.com",
            "user.name@domain.com",
            "user123@domain.com",
            "user+name@domain.com"
        )

        for (email in validEmails) {
            emailField.click()
            emailField.clear()
            emailField.sendKeys(email)
            passwordField.click() // blur the field
            Thread.sleep(500)

            val errors = driver!!.findElements(By.cssSelector("div.validation-email-error"))
            Assertions.assertTrue(
                errors.isEmpty() || !errors[0].isDisplayed,
                "Valid email $email showing error after blur"
            )
        }
    }

    // Password Validation Tests
    @Test
    fun testEmptyPasswordAfterBlur() {
        val passwordField = driver!!.findElement(By.id("password"))
        val emailField = driver!!.findElement(By.id("email"))

        // First verify no error is shown initially
        val initialErrors = driver!!.findElements(By.cssSelector("div.validation-password-error"))
        Assertions.assertTrue(initialErrors.isEmpty() || !initialErrors[0].isDisplayed,
            "Error should not be shown before interaction")

        // Click into password field
        passwordField.click()
        // Click out without entering anything
        emailField.click()
        Thread.sleep(500)

        val error = driver!!.findElement(By.cssSelector("div.validation-password-error"))
        Assertions.assertEquals("This field is required", error.text,
            "Empty password error should appear after field is blurred")
    }

    @Test
    fun testPasswordLengthValidation() {
        val passwordField = driver!!.findElement(By.id("password"))
        val emailField = driver!!.findElement(By.id("email"))

        // Click into field
        passwordField.click()
        passwordField.clear()
        passwordField.sendKeys("Abc1!")
        // Click out to trigger validation
        emailField.click()
        Thread.sleep(500)

        val error = driver!!.findElement(By.cssSelector("div.validation-password-error"))
        Assertions.assertTrue(
            error.text.contains("Password have from 8 to 20 characters long"),
            "Short password error not shown after blur"
        )
    }

    @Test
    fun testEmptyPassword() {
        val emailField = driver!!.findElement(By.id("email"))
        val passwordField = driver!!.findElement(By.id("password"))

        // Enter valid email first
        emailField.clear()
        emailField.sendKeys("test@example.com")

        // Test empty password
        passwordField.click()
        emailField.click() // Click away to trigger validation
        Thread.sleep(1000)

        val emptyError = driver!!.findElement(By.cssSelector("div.validation-password-error"))
        Assertions.assertEquals("This field is required", emptyError.text,
            "Wrong error message for empty password")
    }

    @Test
    fun testTooLongPassword() {
        val emailField = driver!!.findElement(By.id("email"))
        val passwordField = driver!!.findElement(By.id("password"))

        // Enter valid email first
        emailField.clear()
        emailField.sendKeys("test@example.com")

        // Test too long password
        val tooLongPassword = "aB1!aB1!aB1!aB1!aB1!dfsdfsdfsd" // More than 20 chars
        passwordField.clear()
        passwordField.sendKeys(tooLongPassword)
        emailField.click()
        Thread.sleep(1000)

        val errorMessage = driver!!.findElement(By.cssSelector("div.validation-password-error"))
        Assertions.assertEquals("Password must be less than 20 characters long without spaces.",
            errorMessage.text, "Wrong error message for too long password")
    }

    @Test
    fun testInvalidPasswordFormats() {
        val emailField = driver!!.findElement(By.id("email"))
        val passwordField = driver!!.findElement(By.id("password"))

        // Enter valid email first
        emailField.clear()
        emailField.sendKeys("test@example.com")

        val baseErrorMessage = "Password have from 8 to 20 characters long without spaces and contain at least one " +
                "uppercase letter (A-Z), one lowercase letter (a-z), a digit (0-9), and a special character (~`!@#$%^&*()+=_-{}[]|:;”’?/<>,.)"

        val invalidPasswords = listOf(
            "a",                // Too short
            "abcdefgh",        // Only lowercase
            "ABCDEFGH",        // Only uppercase
            "12345678",        // Only numbers
            "!@#$%^&*",        // Only special chars
            "Abcdefgh",        // Missing number and special
            "abcd12!@",        // Missing uppercase
            "ABCD12!@",        // Missing lowercase
            "Ab1! def@",       // Space in middle
            " Ab1!def@",       // Space at start
            "Ab1!def@ "        // Space at end
        )

        for (password in invalidPasswords) {
            passwordField.clear()
            Thread.sleep(500)
            passwordField.sendKeys(password)
            Thread.sleep(500)
            emailField.click()
            Thread.sleep(1000)

            try {
                val errorMessage = driver!!.findElement(By.cssSelector("div.validation-password-error"))
                val actualError = errorMessage.text
                Assertions.assertEquals(baseErrorMessage, actualError,
                    "Wrong error message for password: $password")
            } catch (e: Exception) {
                throw AssertionError("Failed to validate password: $password", e)
            }
        }
    }
    @Test
    fun testNoInitialValidationErrors() {
        // Check that no validation errors are shown when the form first loads
        val emailErrors = driver!!.findElements(By.cssSelector("div.validation-email-error"))
        val passwordErrors = driver!!.findElements(By.cssSelector("div.validation-password-error"))

        Assertions.assertTrue(emailErrors.isEmpty() || !emailErrors[0].isDisplayed,
            "Email error should not be shown initially")
        Assertions.assertTrue(passwordErrors.isEmpty() || !passwordErrors[0].isDisplayed,
            "Password error should not be shown initially")
    }

    @Test
    fun testCompleteValidFormSubmission() {
        val emailField = driver!!.findElement(By.id("email"))
        val passwordField = driver!!.findElement(By.id("password"))

        // Enter valid email and password with proper field interaction
        emailField.click()
        emailField.sendKeys("valid@email.com")
        passwordField.click() // blur email field

        passwordField.sendKeys("ValidPass1!")
        emailField.click() // blur password field
        Thread.sleep(500)

        val emailErrors = driver!!.findElements(By.cssSelector("div.validation-email-error"))
        val passwordErrors = driver!!.findElements(By.cssSelector("div.validation-password-error"))

        Assertions.assertTrue(emailErrors.isEmpty() || !emailErrors[0].isDisplayed,
            "No email errors should be shown for valid input")
        Assertions.assertTrue(passwordErrors.isEmpty() || !passwordErrors[0].isDisplayed,
            "No password errors should be shown for valid input")
    }
}