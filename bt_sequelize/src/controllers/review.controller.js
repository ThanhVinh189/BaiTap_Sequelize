import { resposeSuccess } from "../common/helpers/reponse.helper";
import reviewService from "../services/review.service";

const reviewController = {
  addReview: async (req, res, next) => {
    try {
      const { user_id, res_id, amount, date_rate } = req.body;
      const review = await reviewService.addReview({
        user_id,
        res_id,
        amount,
        date_rate,
      });
      const response = resposeSuccess(
        review,
        `Thêm đánh giá nhà hàng thành công`
      );
      res.status(response.statusCode).json(response);
    } catch (error) {
      next(error);
    }
  },

  deleteReview: async (req, res, next) => {
    try {
      const user_id = parseInt(req.params.user_id, 10);
      const res_id = parseInt(req.params.res_id, 10);
      const result = await reviewService.deleteReview({ user_id, res_id });
      const response = resposeSuccess(result, "Xóa đánh giá thành công");
      res.status(response.statusCode).json(response);
    } catch (error) {
      next(error);
    }
  },

  getReviewsByRestaurant: async (req, res, next) => {
    try {
      const res_id = parseInt(req.params.res_id);
      const reviews = await reviewService.getReviewsByRestaurant(res_id);
      const response = resposeSuccess(
        reviews,
        `Lấy danh sách đánh giá theo nhà hàng thành công`
      );
      res.status(response.statusCode).json(response);
    } catch (error) {
      next(error);
    }
  },

  getReviewsByUser: async (req, res, next) => {
    try {
      const user_id = parseInt(req.params.user_id);
      const reviews = await reviewService.getReviewsByUser(user_id);
      const response = resposeSuccess(
        reviews,
        `Lấy danh sách đánh giá theo người dùng thành công`
      );
      res.status(response.statusCode).json(response);
    } catch (error) {
      next(error);
    }
  },
};

export default reviewController;
