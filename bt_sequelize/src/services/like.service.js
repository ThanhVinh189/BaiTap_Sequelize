import { BadRequestException } from "../common/helpers/exception.helper";
import prisma from "../common/prisma/init.prisma";
import logger from "../common/winston/init.winston";

const likeService = {
  likeRestaurant: async ({ user_id, res_id }) => {
    // Kiểm tra xem người dùng đã like nhà hàng này chưa
    const existingLike = await prisma.like_res.findUnique({
      where: {
        user_id_res_id: { user_id, res_id },
      },
    });
    if (existingLike) {
      logger.error(`Người dùng đã like nhà hàng này rồi.`);
      throw new BadRequestException("Người dùng đã like nhà hàng này rồi.");
    }

    const like = await prisma.like_res.create({
      data: { user_id: user_id, res_id: res_id },
    });
    return like;
  },
  unlikeRestaurant: async ({ user_id, res_id }) => {
    const deleted = await prisma.like_res.delete({
      where: { user_id_res_id: { user_id, res_id } },
    });
    return deleted;
  },
  getLikesByRestaurant: async (res_id) => {
    const likes = await prisma.like_res.findMany({
      where: { res_id: res_id },
    });

    return likes;
  },
  getLikesByUser: async (user_id) => {
    const likes = await prisma.like_res.findMany({
      where: { user_id },
    });
    return likes;
  },
};

export default likeService;
