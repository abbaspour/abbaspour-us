function login(email, password, callback) {
    const user = {
        user_id: `d-${email}`,
        email,
    };
    console.log(`db login email ${email} returning profile: ${JSON.stringify(user)}`);
    return callback(null, user);
}