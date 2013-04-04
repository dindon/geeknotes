ensureAuthenticated = (req, res, next) ->
    return next() if req.isAuthenticated()
    res.redirect "/identification"

app.all /^\/admin.+$/, ensureAuthenticated