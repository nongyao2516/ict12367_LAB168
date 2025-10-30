<template>
  <div class="container mt-4">
    <h2 class="mb-3">รายการพนักงาน</h2>

    <div class="mb-3">
      <button class="btn btn-primary" @click="openAddModal">เพิ่มพนักงาน +</button>
    </div>

    <table class="table table-bordered table-striped">
      <thead class="table-primary">
        <tr>
          <th>ID</th>
          <th>ชื่อ</th>
          <th>นามสกุล</th>
          <th>ชื่อผู้ใช้</th>
          <th>รูปภาพ</th>
          <th>การจัดการ</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="emp in employees" :key="emp.employee_id">
          <td>{{ emp.employee_id }}</td>
          <td>{{ emp.firstname }}</td>
          <td>{{ emp.lastname }}</td>
          <td>{{ emp.username }}</td>
          <td>
            <img
              v-if="emp.image"
              :src="'http://localhost/ICT12367_LAB168/php_api/uploads/' + emp.image"
              width="100"
              class="rounded"
            />
          </td>
          <td>
            <button class="btn btn-warning btn-sm me-2" @click="openEditModal(emp)">
              แก้ไข
            </button>
            <button class="btn btn-danger btn-sm" @click="deleteEmployee(emp.employee_id)">
              ลบ
            </button>
          </td>
        </tr>
      </tbody>
    </table>

    <div v-if="loading" class="text-center"><p>กำลังโหลดข้อมูล...</p></div>
    <div v-if="error" class="alert alert-danger">{{ error }}</div>

    <!-- Modal เพิ่ม/แก้ไข -->
    <div class="modal fade" id="editModal" tabindex="-1">
      <div class="modal-dialog modal-md">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ isEditMode ? "แก้ไขข้อมูลพนักงาน" : "เพิ่มพนักงานใหม่" }}</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <form @submit.prevent="saveEmployee">
              <div class="mb-3">
                <label class="form-label">ชื่อ</label>
                <input v-model="editForm.firstname" type="text" class="form-control" required />
              </div>
              <div class="mb-3">
                <label class="form-label">นามสกุล</label>
                <input v-model="editForm.lastname" type="text" class="form-control" required />
              </div>
              <div class="mb-3">
                <label class="form-label">ชื่อผู้ใช้</label>
                <input v-model="editForm.username" type="text" class="form-control" required />
              </div>
              <div class="mb-3">
                <label class="form-label">รหัสผ่าน</label>
                <input
                  v-model="editForm.password"
                  type="password"
                  class="form-control"
                  :required="!isEditMode"
                  placeholder="(กรอกเมื่อเพิ่มใหม่หรือเปลี่ยนรหัสผ่าน)"
                />
              </div>
              <div class="mb-3">
                <label class="form-label">รูปภาพ</label>
                <input
                  type="file"
                  @change="handleFileUpload"
                  class="form-control"
                />
                <div v-if="isEditMode && editForm.image" class="mt-2">
                  <p>รูปเดิม:</p>
                  <img
                    :src="'http://localhost/ICT12367_LAB168/php_api/uploads/' + editForm.image"
                    width="100"
                    class="rounded"
                  />
                </div>
              </div>

              <button type="submit" class="btn btn-success">
                {{ isEditMode ? "บันทึกการแก้ไข" : "บันทึกพนักงานใหม่" }}
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";

export default {
  name: "EmployeeList",
  setup() {
    const employees = ref([]);
    const loading = ref(true);
    const error = ref(null);
    const isEditMode = ref(false);
    const editForm = ref({
      employee_id: null,
      firstname: "",
      lastname: "",
      username: "",
      password: "",
      image: "",
    });
    const newImageFile = ref(null);
    let modalInstance = null;

    // โหลดข้อมูลพนักงาน
    const fetchEmployees = async () => {
      try {
        const res = await fetch("http://localhost/ICT12367_LAB168/php_api/api_employee.php");
        const data = await res.json();
        employees.value = data.success ? data.data : [];
      } catch (err) {
        error.value = err.message;
      } finally {
        loading.value = false;
      }
    };

    // เปิด modal เพิ่ม
    const openAddModal = () => {
      isEditMode.value = false;
      editForm.value = {
        employee_id: null,
        firstname: "",
        lastname: "",
        username: "",
        password: "",
        image: "",
      };
      newImageFile.value = null;

      const modalEl = document.getElementById("editModal");
      modalInstance = new window.bootstrap.Modal(modalEl);
      modalInstance.show();

      const fileInput = modalEl.querySelector('input[type="file"]');
      if (fileInput) fileInput.value = "";
    };

    // เปิด modal แก้ไข
    const openEditModal = (emp) => {
      isEditMode.value = true;
      editForm.value = { ...emp, password: "" };
      newImageFile.value = null;

      const modalEl = document.getElementById("editModal");
      modalInstance = new window.bootstrap.Modal(modalEl);
      modalInstance.show();

      const fileInput = modalEl.querySelector('input[type="file"]');
      if (fileInput) fileInput.value = ""; // เคลียร์ input แต่ยังแสดงรูปเดิม
    };

    const handleFileUpload = (event) => {
      newImageFile.value = event.target.files[0];
    };

    const saveEmployee = async () => {
      const formData = new FormData();
      formData.append("action", isEditMode.value ? "update" : "add");
      if (isEditMode.value) formData.append("employee_id", editForm.value.employee_id);
      formData.append("firstname", editForm.value.firstname);
      formData.append("lastname", editForm.value.lastname);
      formData.append("username", editForm.value.username);
      if (editForm.value.password) formData.append("password", editForm.value.password);
      if (newImageFile.value) formData.append("image", newImageFile.value);

      try {
        const res = await fetch("http://localhost/ICT12367_LAB168/php_api/api_employee.php", {
          method: "POST",
          body: formData,
        });
        const result = await res.json();
        if (result.message) {
          alert(result.message);
          fetchEmployees();
          modalInstance.hide();
        } else if (result.error) {
          alert(result.error);
        }
      } catch (err) {
        alert(err.message);
      }
    };

    const deleteEmployee = async (id) => {
      if (!confirm("คุณแน่ใจหรือไม่ที่จะลบพนักงานนี้?")) return;

      const formData = new FormData();
      formData.append("action", "delete");
      formData.append("employee_id", id);

      try {
        const res = await fetch("http://localhost/ICT12367_LAB168/php_api/api_employee.php", {
          method: "POST",
          body: formData,
        });
        const result = await res.json();
        if (result.message) {
          alert(result.message);
          employees.value = employees.value.filter((e) => e.employee_id !== id);
        } else if (result.error) {
          alert(result.error);
        }
      } catch (err) {
        alert(err.message);
      }
    };

    onMounted(fetchEmployees);

    return {
      employees,
      loading,
      error,
      editForm,
      isEditMode,
      openAddModal,
      openEditModal,
      handleFileUpload,
      saveEmployee,
      deleteEmployee,
    };
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
