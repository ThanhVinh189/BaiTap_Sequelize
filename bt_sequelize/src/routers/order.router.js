import express from "express";
import orderController from "../controllers/order.controller";

const orderRouter = express.Router();

// Endpoint tạo đơn hàng mới
orderRouter.post("/orders", orderController.addOrder);

// Endpoint lấy danh sách đơn hàng (có thể lọc theo userId hoặc foodId)
orderRouter.get("/orders", orderController.getOrders);

// Endpoint xóa đơn hàng theo order_id
orderRouter.delete("/orders/:order_id", orderController.deleteOrder);

export default orderRouter;
