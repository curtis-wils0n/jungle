describe('Jungle Add to Cart', () => {
  
  it('retrieves the home page', () => {
    cy.visit('/');
  });

  it('clicks "add to cart" and the cart increases by one', () => {
    cy.visit('/');
    cy.contains('My Cart (0)');
    cy.get('.btn').contains('Add')
      .first()
      .click({force: true});
    cy.contains('My Cart (1)');
  });
  
});