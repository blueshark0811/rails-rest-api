import React from 'react';
//
import ErrorBoundary from 'base_components/ErrorBoundary';
/* for code splitting - loadable */
import Loadable from 'react-loadable';
import Loader from 'base_components/Loader';

//------------------------- ADMIN PANEL COMPONENT -------------------------------//
const AsyncAdminGroupManager = Loadable({
  loader: () => import('scenes/Admin/AdminGroupManager'),
  loading: Loader,
  timeout: 10000
});

const AsyncAdminUserManager = Loadable({
  loader: () => import('scenes/Admin/AdminUserManager'),
  loading: Loader,
  timeout: 10000
});

const AsyncAdminCourseCreator = Loadable({
  loader: () => import('scenes/Admin/AdminCourseCreator'),
  loading: Loader,
  timeout: 10000
});

const adminRoutes = [
  {
    id: 'admin01',
    path: '/admin/group-manager',
    strict: true,
    exact: true,
    AsyncComponent: props => (
      <ErrorBoundary errMsg="Something went wrong in displaying the admin group manager page.">
        <AsyncAdminGroupManager {...props} />
      </ErrorBoundary>
    )
  },
  {
    id: 'admin02',
    path: '/admin/user-manager',
    strict: true,
    exact: true,
    AsyncComponent: props => (
      <ErrorBoundary errMsg="Something went wrong in displaying the admin user manager page.">
        <AsyncAdminUserManager {...props} />
      </ErrorBoundary>
    )
  },
  {
    id: 'admin03',
    path: '/admin/course-creator',
    strict: true,
    exact: false,
    AsyncRenderComponent: props => (
      <ErrorBoundary errMsg="Something went wrong in displaying the admin user manager page.">
        <AsyncAdminCourseCreator {...props} />
      </ErrorBoundary>
    )
  }
];

export default adminRoutes;
