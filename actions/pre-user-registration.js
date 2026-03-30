/**
 * @param {Event} event - Details about the context and user that is attempting to register.
 * @param {PreUserRegistrationAPI} api - Interface whose methods can be used to change the behavior of the signup.
 */
exports.onExecutePreUserRegistration = async (event, api) => {
    const crypto = require('crypto');
    console.log(`running onExecutePreUserRegistration for event: ${JSON.stringify(event)}`);
    api.user.setUserId('i-' + crypto.randomUUID());
};