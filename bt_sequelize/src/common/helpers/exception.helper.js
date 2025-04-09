import { statusCodes } from "./status-code.helper";

export class BadRequestException extends Error {
  constructor(message = `BadRequestException`) {
    super(message);
    this.statusCode = statusCodes.BAD_REQUEST; // 400
  }
}

export class UnAuthorizedException extends Error {
  constructor(message = `UnAuthorizedException`) {
    super(message);
    this.statusCode = statusCodes.UNAUTHORIZED; // 401
  }
}

export class ForbiddenException extends Error {
  constructor(message = `ForbiddenException`) {
    super(message);
    this.statusCode = statusCodes.FORBIDDEN; // 403
  }
}
