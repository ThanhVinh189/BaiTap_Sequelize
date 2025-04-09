import { BadRequestException } from "../common/helpers/exception.helper";
import prisma from "../common/prisma/init.prisma";
import logger from "../common/winston/init.winston";

const reviewService = {
  addReview: async ({ user_id, res_id, amount, date_rate }) => {
    if (isNaN(amount)) {
      logger.error("Giá trị amount không được chứa chữ và phải là số.");
      throw new BadRequestException(
        "Giá trị amount không được chứa chữ và phải là số."
      );
    }
    if (amount < 1 || amount > 5) {
      logger.error(`Giá trị amount phải nằm trong khoảng từ 1 đến 5.`);
      throw new BadRequestException(
        "Giá trị amount phải nằm trong khoảng từ 1 đến 5."
      );
    }
    const review = await prisma.rate_res.create({
      data: { user_id, res_id, amount, date_rate },
    });
    return review;
  },

  deleteReview: async ({ user_id, res_id }) => {
    // Kiểm tra xem review có tồn tại không
    const existingReview = await prisma.rate_res.findUnique({
      where: {
        user_id_res_id: { user_id, res_id },
      },
    });
    if (!existingReview) {
      logger.error("Không tìm thấy đánh giá cho nhà hàng này.");
      throw new NotFoundException("Không tìm thấy đánh giá cho nhà hàng này.");
    }
    // Nếu tồn tại, xóa review
    const deletedReview = await prisma.rate_res.delete({
      where: {
        user_id_res_id: { user_id, res_id },
      },
    });
    logger.info("Đánh giá đã được xóa thành công.");
    return deletedReview;
  },
  
  getReviewsByRestaurant: async (res_id) => {
    const reviews = await prisma.rate_res.findMany({
      where: { res_id },
    });
    return reviews;
  },

  getReviewsByUser: async (user_id) => {
    const reviews = await prisma.rate_res.findMany({
      where: { user_id },
    });
    return reviews;
  },
};

export default reviewService;
