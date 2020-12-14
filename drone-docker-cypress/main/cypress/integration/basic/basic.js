describe("basic", function () {
    it("should return a 200", function () {
        cy.request("/")
        .should((response) => {
            expect(response.status).to.eq(200);
        });
    });
    it("should return a page not found", function () {
        cy.request(
            {
                url: '/notfound',
                failOnStatusCode: false
            }
        ) .should((response) => {
            expect(response.status).to.eq(404);
        });
    });
});