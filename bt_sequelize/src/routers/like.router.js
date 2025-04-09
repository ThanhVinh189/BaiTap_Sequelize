import express from "express";
import likeController from "../controllers/like.controller";

const likeRouter = express.Router();

// Thêm like cho nhà hàng
likeRouter.post("/restaurants/:res_id/like", likeController.likeRestaurant);

// Bỏ like cho nhà hàng
likeRouter.delete(
  "/restaurants/:res_id/unlike",
  likeController.unlikeRestaurant
);

// Lấy danh sách like theo nhà hàng
likeRouter.get(
  "/restaurants/:res_id/likes",
  likeController.getLikesByRestaurant
);

// Lấy danh sách like theo user
likeRouter.get("/users/:user_id/likes", likeController.getLikesByUser);

export default likeRouter;
