import express from "express";
import rootRouter from "./src/routers/root.router";
import { handleError } from "./src/common/helpers/error.helper";
import logger from "./src/common/winston/init.winston";

const app = express();
app.use(express.json());

app.use(rootRouter);
app.use(handleError);

app.listen(3000, () => {
  logger.info("Server online at http://localhost:3000", { tag: "SERVER" });
});
