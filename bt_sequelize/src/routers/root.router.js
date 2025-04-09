import express from "express";
import likeRouter from "./like.router";
import reviewRouter from "./review.router";
import orderRouter from "./order.router";

const rootRouter = express.Router();

rootRouter.use("/api", likeRouter);
rootRouter.use("/api", reviewRouter);
rootRouter.use("/api", orderRouter);

export default rootRouter;
