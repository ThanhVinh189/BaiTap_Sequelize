import { resposeSuccess } from "../common/helpers/reponse.helper.js";
import orderService from "../services/order.service.js";

const orderController = {
  // Tạo mới đơn hàng
  addOrder: async (req, res, next) => {
    try {
      // Giả sử dữ liệu được truyền từ body có các trường: user_id, food_id, amount, code, subIds
      const { user_id, food_id, amount, code, subIds } = req.body;
      const order = await orderService.addOrder({
        user_id,
        food_id,
        amount,
        code,
        subIds,
      });
      const response = resposeSuccess(order, "Đơn hàng được tạo thành công.");
      res.status(response.statusCode).json(response);
    } catch (error) {
      next(error);
    }
  },
  // Lấy danh sách đơn hàng (có thể lọc theo userId hoặc food_id qua query string)
  getOrders: async (req, res, next) => {
    try {
      const { userId, food_id } = req.query;
      const orders = await orderService.getOrders({
        userId: userId ? parseInt(userId, 10) : undefined,
        food_id: food_id ? parseInt(food_id, 10) : undefined,
      });
      const response = resposeSuccess(
        orders,
        "Lấy danh sách đơn hàng thành công."
      );
      res.status(response.statusCode).json(response);
    } catch (error) {
      next(error);
    }
  },
  // Xóa đơn hàng theo id
  deleteOrder: async (req, res, next) => {
    try {
      const order_id = parseInt(req.params.order_id, 10);
      const deleted = await orderService.deleteOrder(order_id);
      const response = resposeSuccess(
        deleted,
        "Đơn hàng đã được xóa thành công."
      );
      res.status(response.statusCode).json(response);
    } catch (error) {
      next(error);
    }
  },
};

export default orderController;
