import React from 'react';

import Button from 'base_components/Button';
import UserAvatar from 'base_components/UserAvatar';
import avatarSrc from 'resources/images/user.png';
import iconOpenSrc from './open-file.svg';

const QuestionPanelContent = () => {
  const { container, form } = questionPanelContentStyle;
  return (
    <div style={container} className="PanelContent">
      <UserAvatar image={avatarSrc} />
      <form style={form} action="">
        <input
          style={form.input}
          type="text"
          name="quesstion"
          placeholder="Write your answer"
        />
        <div style={form.div}>
          <img style={form.div.icon} alt="Open doc icon" src={iconOpenSrc} />
          <Button text="Submit" />
        </div>
      </form>
    </div>
  );
};

const questionPanelContentStyle = {
  container: {
    display: 'flex'
  },
  form: {
    marginLeft: '0.6em',
    flexGrow: 1,
    input: {
      width: '100%',
      border: '1px solid #dddddd',
      padding: '1em',
      fontSize: 14,
      borderRadius: 4,
      marginBottom: '0.4em',
      outline: 0
    },
    div: {
      display: 'flex',
      float: 'right',
      icon: {
        marginRight: '1em',
        cursor: 'pointer'
      }
    }
  }
};

export default QuestionPanelContent;
