<template>
  <div>
    <nav class="navbar navbar-expand-lg" style="background-color: #86bfe7ff;">
      <div class="container">
        <router-link class="navbar-brand text-white" to="/">Navbar</router-link>

        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <template v-if="userRole === 'admin'">
              <!-- admin menu -->
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">Product</a>
                <ul class="dropdown-menu">
                  <li><router-link class="dropdown-item" to="/product">Product</router-link></li>
                  <li><router-link class="dropdown-item" to="/product_edit">Product CRUD</router-link></li>
                </ul>
              </li>
              <li class="nav-item">
                <router-link class="nav-link" to="/employees">Employee</router-link>
              </li>
              <li class="nav-item">
                <a class="nav-link text-danger" href="#" @click="logout">Logout</a>
              </li>
            </template>

            <template v-else-if="userRole === 'customer'">
              <!-- customer menu -->
              <li class="nav-item">
                <router-link class="nav-link" to="/">Home</router-link>
              </li>
              <li class="nav-item">
                <router-link class="nav-link" to="/showproduct">Show Product</router-link>
              </li>
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">Customer</a>
                <ul class="dropdown-menu">
                  <li><router-link class="dropdown-item" to="/customer">Customer</router-link></li>
                  <li><router-link class="dropdown-item" to="/customer_edit">Customer Edit</router-link></li>
                </ul>
              </li>
              <li class="nav-item">
                <router-link class="nav-link" to="/about">About</router-link>
              </li>
              <li class="nav-item">
                <a class="nav-link text-danger" href="#" @click="logout">Logout</a>
              </li>
            </template>

            <template v-else>
              <!-- guest menu -->
              <li class="nav-item">
                <router-link class="nav-link active" to="/">Home</router-link>
              </li>
              <li class="nav-item">
                <router-link class="nav-link" to="/showproduct">Show Product</router-link>
              </li>
              <li class="nav-item">
                <router-link class="nav-link" to="/about">About</router-link>
              </li>
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">Login</a>
                <ul class="dropdown-menu">
                  <li><router-link class="dropdown-item" to="/login">Login (User)</router-link></li>
                  <li><router-link class="dropdown-item" to="/login_admin">Login (Admin)</router-link></li>
                  <li><router-link class="dropdown-item" to="/register">Register</router-link></li>
                </ul>
              </li>
                <li class="nav-item">
                <a class="nav-link text-danger" href="#" @click="logout">Logout</a>
              </li>
            </template>
          </ul>

          <form class="d-flex" role="search">
            <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" />
            <button class="btn btn-outline-light" type="submit">Search</button>
          </form>
        </div>
      </div>
    </nav>

    <router-view />
  </div>
</template>

<script>
export default {
  name: "Navbar",
  data() {
    return {
      userRole: "guest", // admin | customer | guest
    };
  },
  mounted() {
    this.checkUserRole();
    // ถ้ามีการเปลี่ยนแปลง localStorage จากแท็บอื่น จะอัปเดตด้วย
    window.addEventListener("storage", this.checkUserRoleFromEvent);
  },
  beforeUnmount() {
    window.removeEventListener("storage", this.checkUserRoleFromEvent);
  },
  methods: {
    // wrapper เพื่อใช้ทั้ง watch และ storage event
    checkUserRoleFromEvent() {
      this.checkUserRole();
    },

    // อ่านคีย์หลายแบบ แล้ว normalize ไปเป็น role
    checkUserRole() {
      // 1) อ่านคีย์มาตรฐาน (ถ้ามี)
      const roleKey = localStorage.getItem("role");
      if (roleKey === "admin" || roleKey === "customer") {
        this.userRole = roleKey;
        return;
      }

      // 2) อ่านคีย์เก่าที่อาจมีในโปรเจกต์ของคุณ
      // map เก่า -> role
      const mappings = [
        { key: "admin", role: "admin" },
        { key: "customer", role: "customer" }
      ];

      for (const m of mappings) {
        if (localStorage.getItem(m.key) === "true") {
          this.userRole = m.role;
          // เขียนกลับเป็นคีย์มาตรฐานเพื่อให้ครั้งถัดไปตรงกัน
          try {
            localStorage.setItem("role", m.role);
          } catch (e) {
            // ignore (บาง environment localStorage อาจเต็มหรือถูกบล็อก)
          }
          return;
        }
      }

      // ถ้าไม่พบ คือต้องเป็น guest
      this.userRole = "guest";
    },

    logout() {
      if (confirm("ต้องการออกจากระบบหรือไม่?")) {
        localStorage.removeItem("role");
        localStorage.removeItem("admin");
        localStorage.removeItem("customer");
        localStorage.removeItem("username");
        this.userRole = "guest";
        this.$router.push("/");  // ออกระบบ Logout ต้องการให้ไปแสดงหน้าใดให้ระบุส่วนนี้
      }
    },
  },
  watch: {
    // เมื่อเส้นทางเปลี่ยน ให้ตรวจสอบใหม่ (บางครั้ง login อาจ redirect)
    $route() {
      this.checkUserRole();
    },
  },
};
</script>

<style scoped>
.navbar {
  background-color: #86bfe7ff !important;
}
.nav-link {
  color: white !important;
  font-weight: 500;
}
.nav-link:hover {
  text-decoration: underline;
}
</style>
