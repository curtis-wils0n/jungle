describe('Jungle User Login', () => {
  
  it('retrieves the home page', () => {
    cy.visit('/')
  });

  it('clicks "Sign Up" and creates a user', () => {
    cy.visit('/')
    cy.contains('Sign Up')
      .click()
    cy.get('#user_first_name')
      .type('Test')
    cy.get('#user_last_name')
      .type('McTest')
    cy.get('#user_email')
      .type('test@test.com')
    cy.get('#user_password')
      .type('test123')
    cy.get('#user_password_confirmation')
      .type('test123')
    cy.get('form')
      .submit()
    cy.contains('Signed in as Test')
  });

  it('clicks "Login" and successfully logs the user in', () => {
    cy.visit('/')
    cy.contains('Login')
      .click()
    cy.get('#email')
      .type('test5@test.com')
    cy.get('#password')
      .type('test123')
    cy.get('form')
      .submit()
    cy.contains('Signed in as Test')
  });

});