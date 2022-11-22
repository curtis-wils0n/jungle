describe('Jungle Product Page', () => {
  
  it('retrieves the home page', () => {
    cy.visit('/');
  });

  it('clicks the first listed product', () => {
    cy.visit('/');
    cy.get('.products article').first()
      .click();
    cy.url().should('include', '/products/2');
  });

  it('clicks the last listed product', () => {
    cy.visit('/');
    cy.get('.products article').last()
      .click();
    cy.url().should('include', '/products/1');
  });

});