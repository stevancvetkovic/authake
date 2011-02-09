<div id="authake">
	<?php echo $this->renderElement('gotohomepage'); ?>
	<div class="login form">
		<?php echo $form->create(null, array('action'=>'login'));?>
			<fieldset>
			<?php
				echo $form->input('login', array('label'=>__('Login:', true), 'size'=>'14'));
				echo $form->input('password', array('label'=>__('Password:', true), 'value' => '', 'size'=>'14'));
			?>
			</fieldset>
		<?php echo $form->end(__('Login', true))  ?>
		<p class="lostpassword" style="margin-left: 16em;">
			<?php echo $html->link(__("Forgot your password?", true), array('action'=>'mypassword'))."<br/>"; ?>
		</p>
	</div>
</div>
