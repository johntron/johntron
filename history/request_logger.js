module.exports = (req, res, next) => {
  next();
  console.log(req.url, res.statusCode);
};
