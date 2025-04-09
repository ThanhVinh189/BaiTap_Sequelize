import prisma from "../common/prisma/init.prisma";
import { BadRequestException } from "../common/helpers/exception.helper";
import logger from "../common/winston/init.winston";
import { generateUniqueOrderCode } from "../common/helpers/order.helper";

const orderService = {
  /**
   * Tạo đơn hàng mới và thêm thông tin của các sub_food thông qua bảng order_sub_food.
   * @param {Object} data
   * @param {number} data.user_id
   * @param {number} data.food_id
   * @param {number} data.amount
   * @param {string} data.code
   * @param {Array<number>} data.subIds (ví dụ: [1,2,3]).
   * @returns Đơn hàng được tạo.
   */
  addOrder: async ({ user_id, food_id, amount, code, subIds }) => {
    if (!user_id || !food_id || !amount) {
      logger.error("Thiếu thông tin bắt buộc cho đơn hàng.");
      throw new BadRequestException("Thiếu thông tin bắt buộc cho đơn hàng.");
    }

    // Kiểm tra code: nếu không phải string hợp lệ, tự tạo mã đơn hàng mới.
    const orderCode =
      typeof code === "string" && code.trim() !== ""
        ? code
        : await generateUniqueOrderCode();

    const result = await prisma.$transaction(async (prisma) => {
      const order = await prisma.orders.create({
        data: {
          user_id: user_id,
          food_id: food_id,
          amount,
          code: orderCode,
        },
      });

      if (Array.isArray(subIds) && subIds.length > 0) {
        const orderSubFoodsData = subIds.map((sub_id) => ({
          order_id: order.order_id,
          sub_id: sub_id,
        }));

        await prisma.order_sub_food.createMany({
          data: orderSubFoodsData,
        });
      }
      return order;
    });

    logger.info(
      `Đơn hàng ${result.order_id} được tạo thành công với mã ${orderCode}.`
    );
    return result;
  },

  /**
   * Lấy danh sách đơn hàng theo các điều kiện lọc.
   * @param {Object} filters
   * @param {number} [filters.user_id]
   * @param {number} [filters.food_id]
   * @returns
   */
  getOrders: async ({ user_id, food_id }) => {
    const filter = {};
    if (user_id) filter.user_id = user_id;
    if (food_id) filter.food_id = food_id;
    const orders = await prisma.orders.findMany({
      where: filter,
      // Bao gồm thông tin các sub_food liên quan nếu cần
      include: { order_sub_food: true },
    });
    return orders;
  },

  /**
   * Xóa đơn hàng theo order_id.
   * @param {number} order_id
   * @returns
   */
  deleteOrder: async (order_id) => {
    // Kiểm tra xem đơn hàng có tồn tại không
    const order = await prisma.orders.findUnique({
      where: { order_id: order_id },
    });
    if (!order) {
      logger.error(`Order ${order_id} không tồn tại.`);
      throw new NotFoundException(`Order ${order_id} không tồn tại.`);
    }

    // Xóa đơn hàng
    const deleted = await prisma.orders.delete({
      where: { order_id: order_id },
    });
    logger.info(`Order ${order_id} đã được xóa thành công.`);
    return deleted;
  },
};

export default orderService;
