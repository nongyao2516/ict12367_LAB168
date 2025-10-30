import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/about',
    name: 'about',
    component: () => import('../views/AboutView.vue')
  },
  {
    path: '/showproduct',
    name: 'showproduct',
    component: () => import('../views/ShowProduct.vue')
  },
  {
    path: '/customer',
    name: 'customer',
    component: () => import('../views/Customer.vue')
  },
  {
    path: '/add_customer',
    name: 'add_customer',
    component: () => import('../views/Add_customer.vue')
  },
  {
    path: '/student',
    name: 'student',
    component: () => import('../views/Student.vue')
  },
  {
    path: '/product',
    name: 'product',
    component: () => import('../views/Product.vue')
  },
  {
    path: '/Addproduct',
    name: 'Addproduct',
    component: () => import('../views/Add_product.vue')
  },
  {
    path: '/customer_edit',
    name: 'customer_edit',
    component: () => import('../views/customer_edit.vue')
  },
   {
    path: '/product_edit',
    name: 'product_edit',
    component: () => import('../views/product_edit.vue')
  },
  {
    path: '/employees',
    name: 'employees',
    component: () => import('../views/Employee.vue')
  },
   {
    path: '/login',
    name: 'login',
    component: () => import('../views/Login.vue')
  },
    {
    path: '/login_admin',
    name: 'login_admin',
    component: () => import('../views/Login_admin.vue')
  }



]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

// ✅ Navigation Guard
router.beforeEach((to, from, next) => {
  const role = localStorage.getItem("role"); // 'admin' | 'customer' | null
  const isLoggedIn = !!role; // true ถ้ามีการล็อกอิน

  // ✅ ถ้า route ต้องล็อกอิน
  if (to.meta.requiresAuth) {
    if (!isLoggedIn) {
      alert("⚠ กรุณาเข้าสู่ระบบก่อนใช้งานหน้านี้");
      if (to.meta.role === "admin") next("/login_admin");
      else next("/login");
      return;
    }

    // ✅ ถ้ามีการล็อกอินแต่ role ไม่ตรง (ป้องกันเข้า page ผิด)
    if (to.meta.role && to.meta.role !== role) {
      alert("⛔ คุณไม่มีสิทธิ์เข้าหน้านี้");
      next("/");
      return;
    }
  }

  // ✅ ป้องกันไม่ให้กลับไปหน้า login ถ้าเข้าสู่ระบบแล้ว
  if ((to.path === "/login" || to.path === "/login_admin") && isLoggedIn) {
    next("/");
    return;
  }

  next();
});

export default router;



