import express from "express";
import reviewController from "../controllers/review.controller";

const reviewRouter = express.Router();

// Thêm đánh giá cho nhà hàng
reviewRouter.post("/restaurants/:res_id/review", reviewController.addReview);

// Xóa đánh giá cho nhà hàng
reviewRouter.delete(
  "/restaurants/:res_id/review/:user_id",
  reviewController.deleteReview
);

// Lấy danh sách đánh giá theo nhà hàng
reviewRouter.get(
  "/restaurants/:res_id/reviews",
  reviewController.getReviewsByRestaurant
);

// Lấy danh sách đánh giá theo user
reviewRouter.get("/users/:user_id/reviews", reviewController.getReviewsByUser);

export default reviewRouter;
