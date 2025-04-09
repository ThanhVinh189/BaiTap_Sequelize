import prisma from "../prisma/init.prisma";

/**
 * Sinh mã đơn hàng ngẫu nhiên theo định dạng ORDxxx, với xxx là số ngẫu nhiên 3 chữ số.
 * Ví dụ: ORD001, ORD875.
 * @returns {string} Mã đơn hàng ngẫu nhiên.
 */
export function generateRandomOrderCode() {
  const randomNum = Math.floor(Math.random() * 1000); // 0 đến 999
  const paddedNumber = randomNum.toString().padStart(3, "0");
  return `ORD${paddedNumber}`;
}

/**
 * Sinh mã đơn hàng đảm bảo tính duy nhất trong bảng orders.
 * Nếu mã được sinh ra đã tồn tại thì thử lại cho đến khi duy nhất (với tối đa 100 lần thử).
 * @returns {Promise<string>} Mã đơn hàng duy nhất.
 * @throws {Error} Nếu không thể tạo được mã duy nhất sau 100 lần thử.
 */
export async function generateUniqueOrderCode() {
  let code;
  let exists = true;
  let attempts = 0;

  while (exists && attempts < 100) {
    code = generateRandomOrderCode();
    const existingOrder = await prisma.orders.findUnique({ where: { code } });
    exists = Boolean(existingOrder);
    attempts++;
  }

  if (exists) {
    throw new Error("Không thể tạo được mã đơn hàng duy nhất sau 100 lần thử.");
  }

  return code;
}
