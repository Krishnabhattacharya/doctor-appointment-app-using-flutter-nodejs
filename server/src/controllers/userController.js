import Doctor from '../models/doctorModel.js';
import User from '../models/userModel.js'
import bcrypt from 'bcryptjs';
const loginController = async (req, res) => {
  try {
    const user = await User.findOne({ email: req.body.email });
    if (!user) {
      return res.status(200).send({ success: false, message: "user not fount" });
    }
    const pasword = await bcrypt.compare(req.body.password, user.password);
    if (!pasword) {
      return res.status(200).send({ success: false, message: "invaild details" });
    }
    const token = await user.generateToken();
    res.status(200).send({ success: true, message: "login successful", user, token });
  } catch (error) {
  }
}

const registerController = async (req, res) => {
  const user = await new User(req.body);
  try {
    await user.save();
    const token = await user.generateToken();
    console.log(token);
    res.status(201).send({ success: true, message: "register successful", user, token });
  } catch (error) {
    res.status(400).send({ success: false, message: `error while signup ${error.message}` })
  }
}
const getUserData = async (req, res) => {
  const user = req.user;
  res.send({ success: true, user: user });
}
const applyDoctor = async (req, res) => {
  try {
    const newDoctor = await Doctor({ ...req.body, status: "pending" });
    await newDoctor.save();

    const admin = await User.findOne({ isAdmin: true });
    const notifications = admin.notifications;

    notifications.push({
      type: "apply doctor request",
      message: `${newDoctor.name} has applied for a doctor account`,
      data: {
        doctorId: newDoctor._id,
        name: newDoctor.name,
        onClickPath: '/admin/doctors',
      },
    });

    await User.findOneAndUpdate({ _id: admin._id }, { notifications });

    res.status(200).send({
      success: true,
      message: "Doctor account applied successfully",
    });
  } catch (error) {
    res.status(500).send({ success: false, message: error.message });
  }
};
const getallNotification = async (req, res) => {
  try {

    const user = await req.user;
    const seenNotifications = user.seenNotifications;
    const notifications = user.notifications;
    seenNotifications.push(...notifications);
    user.notifications = [];
    const userupdate = await user.save();
    res.status(200).send({
      success: true, message: "all notification mark as reed",
      data: userupdate
    })
  } catch (error) {
    res.status(500).send({
      success: false, message: error.message,
    })
  }
}
const deleteAllNotification = async (req, res) => {
  try {
    const user = await req.user;
    user.seenNotifications = [];

    await user.save();

    res.status(200).send({
      success: true,
      message: "All notifications are deleted",
      user: user,
    });
  } catch (error) {
    res.status(500).send({
      success: false,
      message: error.message,
    });
  }
};



export { loginController, registerController, getUserData, applyDoctor, getallNotification, deleteAllNotification };