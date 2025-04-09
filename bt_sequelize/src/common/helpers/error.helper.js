import { resposeError } from "./reponse.helper";

export const handleError = (err, req, res, next) => {
  // (new Error())
  console.log(err);

  let statusCode = err.statusCode || 500;

  const response = resposeError(err.message, statusCode, err.stack);
  res.status(response.statusCode).json(response);
};
