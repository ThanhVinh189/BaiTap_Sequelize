import { resposeSuccess } from "../common/helpers/reponse.helper";
import likeService from "../services/like.service";

const likeController = {
  likeRestaurant: async (req, res, next) => {
    try {
      const { user_id, res_id } = req.body;
      const result = await likeService.likeRestaurant({ user_id, res_id });
      const response = resposeSuccess(
        result,
        `Thực hiện like nhà hàng thành công`
      );
      res.status(response.statusCode).json(response);
    } catch (error) {
      next(error);
    }
  },
  unlikeRestaurant: async (req, res, next) => {
    try {
      const { user_id, res_id } = req.body;
      const result = await likeService.unlikeRestaurant({ user_id, res_id });
      const response = resposeSuccess(result, `Hủy like nhà hàng thành công`);
      res.status(response.statusCode).json(response);
    } catch (error) {
      next(error);
    }
  },
  getLikesByRestaurant: async (req, res, next) => {
    const res_id = parseInt(req.params.res_id);
    try {
      const likes = await likeService.getLikesByRestaurant(res_id);
      const response = resposeSuccess(
        likes,
        `Lấy danh sách like theo nhà hàng thành công`
      );
      res.status(response.statusCode).json(response);
    } catch (error) {
      next(error);
    }
  },
  getLikesByUser: async (req, res, next) => {
    try {
      const userId = parseInt(req.params.user_id);
      const likes = await likeService.getLikesByUser(userId);
      const response = resposeSuccess(
        likes,
        `Lấy danh sách like theo người dùng thành công`
      );
      res.status(response.statusCode).json(response);
    } catch (error) {
      next(error);
    }
  },
};

export default likeController;
