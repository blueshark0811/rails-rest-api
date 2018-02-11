import React from 'react';

import ListNotification from './components/ListNotification';
import LoadingNotification from './components/LoadingNotification';
import HeaderNotification from './components/HeaderNotification';

const Notifications = () => (
  <div>
    <HeaderNotification>
      <span>clear all</span>
    </HeaderNotification>
    <ListNotification />
    <LoadingNotification />
  </div>
);

export default Notifications;
