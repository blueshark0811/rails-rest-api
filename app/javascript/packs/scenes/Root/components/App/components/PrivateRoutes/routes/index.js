import privateRoutes from './privateRoutes';
import teacherRoutes from './teacherRoutes';
import adminRoutes from './adminRoutes';

// exposing the routes.
export default [...privateRoutes, ...teacherRoutes, ...adminRoutes];
