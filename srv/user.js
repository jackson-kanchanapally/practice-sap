const cds = require("@sap/cds");

module.exports = cds.service.impl(async function () {
  const { User } = this.entities;

  this.on("READ", User, async (req) => {
    const results = await cds.run(req.query);
    return results;
  });

  this.before("CREATE", User, async (req) => {
    const query1 = SELECT.from(User).where({ email: req.data.email });
    const result = await cds.run(query1); // Execute the query using cds.run()
    if (result.length > 0) {
      req.error({
        code: "STEMAILEXISTS",
        message: "Student with such email already exists",
        target: "email",
      });
    }
    
  });
  this.before("UPDATE", User, async (req) => {
    const { email } = req.data;
    if (email) {
      const query = SELECT.from(User)
        .where({ email: email })
        .and({ ID: { "!=": req.data.ID } });
      const result = await cds.run(query);
      if (result.length > 0) {
        req.error({
          code: "STEMAILEXISTS",
          message: "Student with such email already exists",
          target: "email",
        });
      }
    }
  });
});
