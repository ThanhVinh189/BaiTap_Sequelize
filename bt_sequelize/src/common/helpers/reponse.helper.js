export const resposeSuccess = (
  data = null,
  message = "ok",
  statusCode = 200
) => {
  return {
    status: `success`,
    statusCode: statusCode,
    message: message,
    data: data,
    doc: "domain.com/doc-api",
  };
};

export const resposeError = (
  message = "Internal Server Error",
  statusCode = 500,
  stack = null
) => {
  return {
    status: `error`,
    statusCode: statusCode,
    message: message,
    stack: stack,
  };
};
