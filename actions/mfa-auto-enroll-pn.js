/**
 * Handler that will be called during the execution of a PostLogin flow.
 *
 * @param {Event} event - Details about the user and the context in which they are logging in.
 * @param {PostLoginAPI} api - Interface whose methods can be used to change the behavior of the login.
 */
exports.onExecutePostLogin = async (event, api) => {
    function isEnrolled(factor) {
        return event?.user?.enrolledFactors?.some(f => f.type === factor)
    }

    const { TARGET_CLIENT_ID } =  event.secrets || [];

    if(event?.transaction?.protocol === 'oauth2-password' && event?.client?.client_id === TARGET_CLIENT_ID ) {
        if(!isEnrolled('push-notification')) {
            //api.authentication.enrollWith({type: 'push-notification'})
            api.multifactor.enable('guardian');
        } else {
            console.log('Enroll SKIP; already enrolled');
        }
    } else {
        console.log('Enroll SKIP; not password grant against target client');
    }
};