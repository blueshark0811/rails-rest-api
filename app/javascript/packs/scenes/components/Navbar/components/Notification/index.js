import React from 'react';

import RowData from './components/RowData';
import RowLink from './components/RowLink';

import PopoverNoti from './components/PopoverNoti';
import PopoverMessage from './components/PopoverMessage';
import Profile from './components/Profile/index.js';
import avatar from 'resources/images/user.png';
import './styles.css';

const Notification = () => {
  // compose our notification data
  const notiRowData = (
    <ul>
      <RowData
        date="22 Sep 4:00pm"
        message="Hi, Jane can you send me question I asked for the other day when you…"
      />
      <RowData
        date="22 Sep 4:00pm"
        message="Hi, Jane can you send me question I asked for the other day when you…"
      />
      <RowLink text="View All" url="/notifications" />
    </ul>
  );

  // compose our message data.
  const messageRowData = (
    <ul>
      <RowData
        avatar={avatar}
        userName="John Jones"
        date="22 Sep 4:00pm"
        message="Hi, Jane can you send me question I asked for the other day when you…"
      />
      <RowData
        avatar={avatar}
        userName="John Jones"
        date="22 Sep 4:00pm"
        message="Hi, Jane can you send me question I asked for the other day when you…"
      />
      <RowLink text="View All" url="/messages" />
    </ul>
  );

  return (
    <div className="Notification">
      <PopoverNoti notiRowData={notiRowData} />
      <PopoverMessage messageRowData={messageRowData} />
      <Profile userName="Jane Doe" avatar={avatar} />
    </div>
  );
};

export default Notification;
